# CurtainRaiser

## Todo
  
- Rename repoo
- Move to parent org
- Finish README
- Fix the concept of getting started

## Table of contents

1. [Introduction](#introduction)
    1. [Example Usage](#example-usage)
    2. [Parameters](#parameters)
2. [Contributing](#contributing)
    1. [New Developer Script](#new-developer)
3. [Compatibility](#compatibility)
4. [Building](#building)
    1. [Building manually](#building-manually)
    2. [Building the docs manually](#building-docs-manually)
5. [Tests](#tests)
	1. [Running the tests](#running-tests-manually)
6. [Continuous Integration](#ci)
7. [Create a Release](#release)
8. [Older Attempts](#older-attempts)

## Introduction <a name="introduction"></a>

TODO: Gif

### Example Usage <a name="example-usage"></a>

```swift

@Observable
public class ControlViewModel {
  var offset: CGPoint = CGPoint(x: 0.5, y: 0)
  var sections: Int = 10
  var maxShadow: Float = 0.1
  var pleatHeight: Float = 4.0
  var lift: Float = 0
  var enable: Bool = true
  }

struct ContentView {
  @State private var control = ControlViewModel()
  @GestureState var dragOffset: CGSize
}

extension ContentView: View {

  var body: some View {
    content
  }

  private var content: some View {
    VStack {
      Text("Some text")
      Image("gear")
    }
    .frame(width: 300, height: 300)
    .gesture(
      DragGesture()
        .onChanged { gesture in
          control.offset = CGPoint(x: (gesture.location.x / 300),
                                   y: 1.0 - (gesture.location.y / 300))
        }
        .onEnded { _ in
          withAnimation(.spring()) {
            control.offset = CGPoint(x: 0.5, y: 0)
          }
        }
    )
    .curtainRaiser(sections: control.sections,
               maxShadow: control.maxShadow,
               pleatHeight: control.pleatHeight,
               lift: control.lift,
               offset: control.offset,
               enabled: control.enable)
  }

}

```

### Parameters <a name="parameters"></a>

| Parameter | Data Type | Detail |
|----|----|----|
| sections | Int | The number of sections you want to collapse |
| maxShadow | Float | |
| pleatHeight | Float | |
| lift | Float | |
| offset | CGPoint | How much to collapse in the range 0 to 1 |
| enabled | Bool | If the shader is not enabled, then the view itself is rendered |

## Contributing <a name="contributing"></a>

To get started as a new developer on the project, please follow the next steps

## New Developer? <a name="new-developer"></a>

If you are a new developer to the project, we have a script you can run to install all dependencies, there
may be parts that you do-not wish to install, so pick and choose what you need from the script

```
./Scripts/new-developer.sh
```

## Compatibility <a name="compatibility"></a>

This code works for `.iOS(.v17), .macOS(.v14), .visionOS(.v1)`, if you needed a version that worked on an older release, I suggest
investigating Metal Shaders, whilst it's possible to do, via taking a screenshot of the view to apply the effect on. The overhead of
constantly screenshoting (for animated content) may be too much, your mileage may vary

## Building <a name="building"></a>


### Building Manually <a name="building-manually"></a>

```bash
swift build
```

### Building the Docs manually<a name="building-docs-manually"></a>

```bash

PACKAGE_NAME=CurtainRaiser
REPOSITORY_NAME=CurtainRaiser
OUTPUT_PATH=./docs
  
swift package --allow-writing-to-directory $OUTPUT_PATH \
            generate-documentation --target $PACKAGE_NAME \
            --disable-indexing \
            --transform-for-static-hosting \
            --hosting-base-path $REPOSITORY_NAME \
            --output-path $OUTPUT_PATH
```


## Tests <a name="tests"></a>

### Running the tests <a name="running-tests-manually"></a>

```bash
swift test
```


## Continuous Integration <a name="ci"></a>

Continuous Integration (CI) runs every time you push up to the remote GitHub Repo, it will:

- Compile & Test the code
- Check your PR title
- Build the documentation
- Auto assign the author
- Run Swift lint

## Create a release <a name="release"></a>

We can create GitHub sem-ver releases of this Swift Package by using the `build-bump-versions` GitHub Action, only Admins can do this.

If we want to bump the version number, we must:

- Bump `Configuration/Version.xcconfig` version number
- Commit to the repo

When we create a new release, CI will:

- Bump `Configuration/Version.xcconfig` build number
- Create a tag
- Generate the Change log
- Create a release in GitHub

## Older Attempts <a name="older-attempts"></a>

If you `git checkout 9ee2a232943cd4e094382e4cb82120be76ea9c99` you can see that I tried to create this effect
with projection/view/model matrix, by rotating each section and putting that section in the correct place.

Whilst it initially looked ok, the perspective always failed.
