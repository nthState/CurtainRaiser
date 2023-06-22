# Accordion | scruncher | collapse shader

## Table of contents

1. [Introduction](#introduction)
	1. [Tech Stack](#techstack)
2. [Getting Started](#getting-started)
    1. [New Developer Script](#newdev)



## Getting Started <a name="getting-started"></a>

To get started as a new developer on the project, please follow the next steps

## New Developer? <a name="newdev"></a>

If you are a new developer to the project, we have a script you can run to install all dependencies, there
may be parts that you do-not wish to install, so pick and choose what you need from the script

```
./Scripts/new-developer.sh
```


## Todo

- What section am i in?
  = yPosition mod sectionHeight
  
- What is the base of the rotation

- What X direction are we folding in?
  If the section id is even/odd
  
- Debug view
  - Draw lines on the section breaks
  
- How far shold the y position be shifted up as the offset changes
  It's not uniform, the ones at the top, move less than the ones at the bottom
  Can this be behind a flag
  
- Debug should take a DEBUG configuration object
- Debug should only be available in DEBUG builds
- Get rid of that annoying UInt conversion
- Fix gesture view
- Can we pass showDebugControls instead? and show an inspector?
- Angle increases as the offset changes


## Example Swift Code

```swift

struct ContentView {
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
		.gesture(
			DragGesture()
				.onChanged { gesture in
					dragOffset = gesture.translation
				}
				.onEnded { gesture in
					dragOffset = .zero
				}
		)
		.accordion(sections: 12, offset: dragOffset, enabled: true)
	}

}

```

## Requirements / Parameters

- Maximum indent before collapsing
- Angle FOV when we rotate

| Parameter | Detail |
|----|----|
| sections | The number of sections you want to collapse |
| offset | How much to collapse in the range 0 to 1 |
| enabled | If the shader is not enabled, then the view itself is rendered |
