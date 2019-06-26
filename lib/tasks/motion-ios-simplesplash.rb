require 'builder'

module SimpleSplash

  module Storyboard
    StoryboardItem = Struct.new(:name, :attributes, :entries) do
      def to_xml(xml)
        if attributes && attributes.size > 0
          if entries && entries.size > 0
            xml.tag!(name, attributes) do |xml|
              entries.each do |entry|
                entry.to_xml(xml)
              end
            end
          else
            xml.tag!(name, attributes)
          end
        else
          if entries && entries.size > 0
            xml.tag!(name) do |xml|
              entries.each do |entry|
                entry.to_xml(xml)
              end
            end
          else
            xml.tag!(name)
          end
        end
      end
    end

    BASE_COLOUR = {name: "backgroundColor", red: 224, green: 226, blue: 220}

    def self.build(vc_id, colours=[])
      unless colours && colours.size > 0
        colours = [BASE_COLOUR]
      end
      # bg_colour_name = colours[0][:name]

      StoryboardItem.new('document', { type: "com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB",
                                       version: "3.0", toolsVersion: "14460.31",
                                       targetRuntime: "iOS.CocoaTouch",
                                       propertyAccessControl: "none", useAutolayout: "YES",
                                       useTraitCollections: "YES", useSafeAreas: "YES",
                                       colorMatched: "YES", initialViewController: vc_id },
                         [ StoryboardItem.new('device', {id: "retina4_7", orientation: "portrait"},
                                              [StoryboardItem.new("adaptation", {id: "fullscreen" })]),
                           StoryboardItem.new('dependencies', nil,
                                              [StoryboardItem.new("plugIn",
                                                                  {identifier: "com.apple.InterfaceBuilder.IBCocoaTouchPlugin",
                                                                   version: "14460.20"
                                                                  }),
                                               StoryboardItem.new("capability",
                                                                  {name: "Safe area layout guides",
                                                                   minToolsVersion: "9.0"}),
                                               StoryboardItem.new("capability",
                                                                  {name: "documents saved in the Xcode 8 format",
                                                                   minToolsVersion: "8.0"})
                                              ]),
                           StoryboardItem.new('scenes', nil,
                                              [StoryboardItem.new('scene', {sceneID: "S9a-Lo-nRK"},
                                                                  storyboard_objects(vc_id, colours[0]))]),
                           # add_color_resources(colours)
                         ]
      )
    end

    def self.storyboard_objects(vc_id, colour)
      [StoryboardItem.new("objects", nil,
                          [storyboard_vc(vc_id, colour),
                           StoryboardItem.new("placeholder",
                                              {placeholderIdentifier: "IBFirstResponder",
                                               id: "nbj-SD-Ib0", userLabel: "First Responder",
                                               sceneMemberID: "firstResponder"})
                          ]),
       StoryboardItem.new("point", {key:"canvasLocation", x:"-340", y: "-71"})]
    end

    def self.storyboard_vc(vc_id, colour)
      # cap_name = bg_colour_name.clone
      # cap_name[0] = cap_name.slice(0).upcase
      StoryboardItem.new("viewController", { id: vc_id, sceneMemberID: "viewController" },
                         [StoryboardItem.new("view", {key: "view", contentMode: "scaleToFill",
                                                     id: "Ff1-8D-V8f"},
                                            [StoryboardItem.new("rect",
                                                                {key: "frame", x: "0.0", y:"0.0",
                                                                 width: "375", height: "667"}),
                                             StoryboardItem.new("autoresizingMask",
                                                                {key: "autoresizingMask",
                                                                 widthSizable: "YES",
                                                                 heightSizable: "YES"}),
                                             StoryboardItem.new("color",
                                                                {key: colour[:name]}.
                                                                    merge(colour_set(colour))),
                                             StoryboardItem.new("viewLayoutGuide", {key: "safeArea",
                                                                                    id: "7Wg-de-foW"})
                                            ])])
    end

    def self.add_color_resources(colours=[])
      StoryboardItem.new("resources", nil,
                         colours.map { |col| generate_colour_item(col) })
    end

    def self.generate_colour_item(colour)
      cap_name = colour[:name].clone
      cap_name[0] = cap_name.slice(0).upcase
      StoryboardItem.new("namedColor", {name: cap_name},
                         [StoryboardItem.new("color",
                                             {key: colour[:name]}.merge(colour_set(colour)))
                         ])
    end

    def self.colour_set(colour)
      {
          red:   "%.10f" % (colour[:red].to_f / 255.0),
          green: "%.10f" % (colour[:green].to_f / 255.0),
          blue:  "%.10f" % (colour[:blue].to_f / 255.0),
          alpha: "%.3f"  % colour.fetch(:alpha, 1.0),
          colorSpace: "custom",
          customColorSpace: "sRGB"
      }
    end
  end
end

namespace :generate do |ns|
  desc 'Generate a splash screen with a single colour for iOS applications (in a storyboard file)'
  task :simple_splash, :red, :green, :blue do |t, args|
    vc_id = "Ohr-fl-fP5"   # Assign a fixed value, may need to change this in the future

    splash_colour = {name: "backgroundColor",
                     red: args.fetch(:red, 224),
                     green: args.fetch(:green, 226),
                     blue: args.fetch(:blue, 220)}
    puts "\n\n"
    if args[:red].nil? && args[:green].nil? && args[:blue].nil?
      puts "Using the default splash background colour"
      puts "\n"
      puts "You can specify your own values by re-executing the command like:"
      puts "     '$rake generate:simple_splash[<red>,<green>,<blue>]'"
    else
      puts "Using an rgb of #{splash_colour[:red]}:#{splash_colour[:green]}:#{splash_colour[:blue]} for the splash background"
    end
    output = File.open("resources/SimpleSplash.storyboard", 'w')
    xml_builder = Builder::XmlMarkup.new(:target=>output, :indent=>2)
    xml_builder.instruct!
    SimpleSplash::Storyboard.build(vc_id, [splash_colour]).to_xml(xml_builder)
    puts "\n\n*************"
    puts "*Be sure to add: \n\n"
    puts "       app.info_plist['UILaunchStoryboardName'] = 'SimpleSplash'"
    puts "\n  to your Rakefile\n\n"
  end
end