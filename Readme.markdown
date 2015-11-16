# myFramework

An Express App with:

 - React
  - React-Engine
 - Waterline
  - Sails-Postgres for Live
  - Sails-Memory for tests

And a Gruntfile to run it all.

The base for all my apps.

## Usage

I don't reccomend a git pull if you are going to use this as your base.

Download and extract the zip of master and then:

```shell
> cd path_to_app/
> npm install
```

Then running the default `grunt` task will launch the application with grunt watching your source to re-compile on save your less and bundle.
