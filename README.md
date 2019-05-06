# RubyMotion SimpleSplash

Generate a simple splash page to be used in iOS projects, that uses autolayout to fit all devices.

Currently the library uses a fixed colour definition but future releases will enable specifying a colour either by definition (RGB) or from a colorset in the XCAssets.

### Background

I needed a quick, brain-dead simple way of adding a splash screen to my iOS projects. I was adding the `ib` gem, generating the storybaord, opening Xcode and that editing it. All to create a fairly simple XML file that really didn't need all of those extra steps.

## Installation

Add this line to your application's Gemfile:

    gem 'motion-ios-splash'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install motion-ios-splash

## Usage

```bash
 $ bundle exec rake generate:simple_splash
```

This will generate the file `SimpleSplash.storyboard` in the resources directory of your project. RubyMotion will automatically compile this files and copy it to your application resources. You will need to specify that the storyboard file should be used as the splash screen. This is done by adding the following to your `Rakefile`:

```ruby
     app.info_plist['UILaunchStoryboardName'] = 'SimpleSplash'
``` 

You can edit the file once it has been produced if it is not exactly to your liking. You may or may not need to include the `ib` gem and then open using Xcode. Those of you wanting to get you *XML on* can simply open the storyboard file (it is just and XML text file) and hack. YMMV

### Caution
Rerunning the `rake generate:simple_splash` will replace the current `SimpleSplash.storyboard` file with a freshly generated version. Good if you are recovering from a mistaken edit, not so good if you had changes that you wanted to keep. Make a backup if you have changes you wish to save before re-executing the command.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
