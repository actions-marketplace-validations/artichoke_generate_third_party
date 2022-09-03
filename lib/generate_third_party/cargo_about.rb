# frozen_string_literal: true

require 'open3'
require 'shellwords'
require 'stringio'

module Artichoke
  module Generate
    module ThirdParty
      class CargoAbout
        def self.present?
          _out, status = Open3.capture2e('cargo about --version')

          status.success?
        end

        def initialize(config:, manifest_path:, template: nil)
          template = File.join(__dir__, 'cargo_about', 'about.hbs') if template.nil?

          @template = template
          @manifest_path = manifest_path
          @config = config
        end

        attr_reader :manifest_path

        def invoke
          command = ['cargo', 'about', 'generate', @template, '--manifest-path', manifest_path, '--config', @config]
          out, err, status = Open3.capture3(command.shelljoin)

          warn err unless err.strip.empty?

          unless status.success?
            warn 'Generate failed'
            exit 1
          end

          Deps.parse(out)
        end

        def self.third_party_flatfile
          cmd = CargoAbout.new(
            cwd: File.join(__dir__, 'all_targets')
          )

          deps = cmd.invoke
          deps.sort_by!(&:name)

          s = StringIO.new
          first = true
          deps.each do |dep|
            s.puts unless first

            s.puts "#{dep.name} #{dep.version}"
            s.puts ''
            s.puts dep.url
            s.puts
            s.puts dep.license_full_text

            first = false
          end
        end
      end
    end
  end
end
