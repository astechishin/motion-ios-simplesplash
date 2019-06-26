# RubyMotion SimpleSplash

Generate a simple splash page to be used in iOS projects, that uses autolayout to fit all devices.

Currently the library will use a default colour definition or you can specify a colour by definition (RGB).

### Background

I needed a quick, brain-dead simple way of adding a splash screen for my iOS projects. I was adding the `ib` gem, generating the storybaord, opening Xcode and then editing it. All to create a fairly simple XML file that really didn't need all of those extra steps.

## Installation

Add this line to your application's Gemfile:

    gem 'motion-ios-simplesplash'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install motion-ios-simplesplash

## Usage

```bash
 $ bundle exec rake generate:simple_splash
```

This will generate the file `SimpleSplash.storyboard` in the resources directory of your project. RubyMotion will automatically compile this files and copy it to your application resources. You will need to specify that the storyboard file should be used as the splash screen. This is done by adding the following to your `Rakefile`:

```ruby
     app.info_plist['UILaunchStoryboardName'] = 'SimpleSplash'
``` 

You can edit the storyboard file once it has been produced if it is not exactly to your liking. You may or may not need to include the `ib` gem and then open using Xcode. Those of you wanting to get your *XML on* can simply open the storyboard file (it is just and XML text file) and hack. YMMV

The `rake` command above will generate a splash screen with the default background (light gray- Red: 224, Green: 226, Blue: 220). However you can run the command and specify the RGB values to allow you to create a splash screen that matches your application's colour scheme. The values for red, green and blue are in the range 0-255. For example, to create a splash screen with a vibrant yellow background (Red: 255, Green: 255, Blue: 0), execute the following:

```bash
 $ bundle exec rake generate:simple_splash[255,255,0]
```

If there is an existing splash screen file, it will be overwritten with the new values. This is helpful, as you can update the splash screen any time you wish. 
 
### Caution
Rerunning the `rake generate:simple_splash` will replace the current `SimpleSplash.storyboard` file with a freshly generated version. Good if you are recovering from a mistaken edit, not so good if you had changes that you wanted to keep. Make a backup if you have changes you wish to save before re-executing the command.

### Additional Considerations
For most projects, the motion-ios-simplesplash will be single use. Once you have generated your splash screen you are done. If you wish, you can remove the gem from your `Gemfile` once your splash storyboard has been generated, there are no build or runtime dependencies.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
