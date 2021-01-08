# *Project 6: Animation*



## 목표: 애니메이션을 사용해보자.

#### 들어가기에 앞서,

~~~swift

import SwiftUI
//State
struct DraggingGradientExample: View {
    @State private var dragAmount: CGSize = .zero
}

// body 부분
extension DraggingGradientExample {
    var body: some View {
    }
}

// UI Properties
extension DraggingGradientExample {
    private var rectangleGradient: some View {
    }
}


// MARK:- PreView
struct DraggingGradientExample_Previews: PreviewProvider {
    static var previews: some View {
        DraggingGradientExample()
    }
}

~~~



### ContentView.swift -특이점 없음 설명 무!

한가지 Tip은 preview에 accentColor()를 설정할 수 있다는 것. 네비게이션 back 버튼들도 accent color로 설정되기 떄문에 저거 바꾸면 네비 백 버튼 색깔도 바뀜.

```swift
import SwiftUI

struct ContentView: View {
}
extension ContentView {
    var body: some View {
        
        NavigationView {
            List {
                NavigationLink(destination: PulseRingView()) {
                    Text("Pulse Ring")
                }
                NavigationLink(destination: DraggingGradientExample()) {
                    Text("Draggable Gradient")
                }
                NavigationLink(destination: SnakyLettersExample()) {
                    Text("Snaky Letters")
                }
                NavigationLink(destination: VisibilityTransitionExample()) {
                    Text("Show/Hide View Transitions")
                }
                NavigationLink(destination: CornerRotationExample()) {
                    Text("Custom Rotation View Modifier")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .accentColor(.yellow)
    }
}

```

#### DraggingGradientExample.swift

소목표: Gradient를 사용해보자. 옛날에 유행하던 그라이데이션 니트 뭐 그런거 떠올리면 될 듯

먼저 ' rectangleGradient ' 라는 view Property를 만들기

~~~swift
extension DraggingGradientExample {
    private var rectangleGradient: some View {
        LinearGradient(
            //gradient의 설정. 색깔 설정 여러개 넣어도 상관 없음.
            gradient: Gradient(colors: [Color.red, Color.blue]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
        //topLeading은 빨간색이고 bottomTrailing 쪽으로 갈 때마다 점점 파란색이 됨.
    }
}
~~~

애니메이션 등록.

~~~swift

import SwiftUI

struct DraggingGradientExample: View {
    @State private var dragAmount: CGSize = .zero
}

extension DraggingGradientExample {
    var body: some View {
        rectangleGradient
            .frame(width: 320, height: 240)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .offset(dragAmount)
      
      //여기서 gesture 등록. 
            .gesture(
                DragGesture()
                    .onChanged( { dragState in
                        self.dragAmount = dragState.translation
                    })
                    .onEnded( { _ in
                        withAnimation(.spring(), {
                            self.dragAmount = .zero
                        })
                    })
            )
    }
}

extension DraggingGradientExample {
    private var rectangleGradient: some View {
        LinearGradient(
            //gradient의 설정. 색깔 설정
            gradient: Gradient(colors: [Color.red, Color.blue]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
        //스타트 포인트와 엔드포인트.
    }
}


// MARK:- PreView

struct DraggingGradientExample_Previews: PreviewProvider {
    static var previews: some View {
        DraggingGradientExample()
    }
}

~~~



#### SnakyLettersExample.swift

소목표: HSTACK과 ForEach를 사용해서 글자가 따라다니는 애니메이션을 구현해보기.



offset값을 먼저 설정해주고. 어떤 단어를 애니메이션을 할 지 정한다. 

~~~swift
import SwiftUI

struct SnakyLettersExample: View {
    private let letters = Array("ANIMATION")
    @State private var letterBoxColor: Color = .orange
    @State private var dragOffset: CGSize = .zero
}
~~~



Hstack안에 ForEach를 통해 한글자씩 접근한다. 그리고 그 글자 각각마다 modifier를 적용해준다.



~~~swift
extension SnakyLettersExample {
    
    var body: some View {
        HStack(spacing:0) {
            ForEach(0 ..< letters.count) { index in
                Text(String(self.letters[index]))
                    .padding() //사각형만들어주고
                    .font(.headline) //폰트 설정
                    .background(self.letterBoxColor) //색깔 설정.
                    .offset(self.dragOffset) //offset 등록해주고.
                    .animation( //애니메이션 등록.
                        Animation
                            .easeOut(duration: 0.5) //0.5초동안 날라오고
                            .delay(0.1 * Double(index)) //글자 index에 따라서 딜레이를 준다. 순서대로 따라오게 하기 위해서
                    )
                //Text End
            }
        }
      //Hstack에 대해 제스쳐등록.
        .gesture(
            DragGesture()
                .onChanged( { dragState in
                    self.dragOffset = dragState.translation
                })
                .onEnded( { _ in
                    self.dragOffset = .zero
                    self.letterBoxColor = self.letterBoxColor == .purple ? .orange : .purple
                })
        )
    }
}
~~~



#### PulseRingView.swift

소목표: 3D Effect를 구현해보자

먼저 purlse Ring view var 만들자.

~~~swift
// MARK: - View Variables
extension PulseRingView {
    
    var pulseRing: some View {
        Circle()
            .stroke(Color.accentColor, lineWidth: 4)
            .opacity(ringOpacity)
            .scaleEffect(ringScale)
            .animation(
                Animation
                    .easeOut(duration: 1.0)
                    .repeatForever(autoreverses: false)
            )
    }
}
~~~

필요한 State 값을 지정해주자.

~~~swift
struct PulseRingView: View {
    @State private var scaleDuration: Double = 0.4
    @State private var currentBlurRadius: CGFloat = 0.0
    @State private var buttonScale: CGFloat = 1.0
    @State private var ringOpacity: Double = 1
    @State private var ringScale: CGFloat = 0
    @State private var buttonYRotation: Double = 0.0
}
~~~

~~~swift

extension PulseRingView {
    
    var body: some View {
        
        VStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 1.0), {
                    self.buttonYRotation += (2.0 * .pi)
                })
            }, label: {
                Text("Tap me")
                    .foregroundColor(.black)
                    .padding(100)
                    .background(Color.accentColor)
                    .clipShape(Circle())
            })
            .blur(radius: currentBlurRadius / 3)
            .scaleEffect(buttonScale)
            .animation(.easeOut(duration: scaleDuration))
            .rotation3DEffect(
                .radians(buttonYRotation), // 회전은 buttonYRotation 만큼 하면 됨.
                axis: (x: 0.0, y: 1.0, z: 0.0)) // Y축으로 회전 (벡터 생각하시면 될 듯.)
          
            .overlay(pulseRing) 
          //초기상태 ringScale = 0 , ringOpacity = 1.0
            .onAppear() {
                self.ringScale = 2
                self.ringOpacity = 0.0
            }
            //Button 끝
            
            VStack {
                Text("Button Scale")
                
                Slider(
                    value: $buttonScale,
                    in: 0.1 ... 1.0,
                    minimumValueLabel: Text("0.1"), maximumValueLabel: Text("1"), label: {
                        Text("Button Scale")
                    })
            }
            .padding()
        }
    }
}
~~~





#### CornerRotationExample.swift

소목표: 애니메이션을 커스텀해보자.



~~~swift
import SwiftUI

struct CornerRotationExample: View {
    @State private var isShowingRectangle = true
    
}

extension CornerRotationExample {
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.4), {
                    self.isShowingRectangle.toggle()
                })
            }, label: {
                Text("Tap me")
                    .font(.largeTitle)
            })
            
            if isShowingRectangle {
                Rectangle()
                    .fill(Color.blue)
                    .transition(.pivot)
              //.pivot()을 만드는 거임.
            }
        }
    }
}
struct CornerRotationExample_Previews: PreviewProvider {
    static var previews: some View {
        CornerRotationExample()
    }
}

~~~

### CornerRotationModifiers.swift

새로운 View Modifier를 만들거다. 받을 수 있는 값은 angle,anchor이다.

그리고 이걸 사용하게 되면 body 아래처럼 작동할 것이다.

~~~swift
import SwiftUI

struct CornerRoationModfier: ViewModifier {
    let angle : Angle
    let anchor: UnitPoint
    
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(angle, anchor: anchor)
            .clipped()
        
    }
}
~~~

#### View + CornerRoation.swift

extension으로 만들어줌 -> cornerRotation()이라는 이름으로.

~~~swift
import SwiftUI

extension View {
    
    public func cornerRotation(angle: Angle, anchor: UnitPoint) -> some View {
        self.modifier(CornerRoationModfier (
            angle: angle,
            anchor: anchor
        ))
    }
}
~~~

#### PivotTransition.swift



~~~swift
import SwiftUI

extension AnyTransition {
    public static var pivot: AnyTransition {
        .modifier(
            active: CornerRoationModfier(
                angle: .radians(-.pi/2),
                anchor: .topLeading),
            identity: CornerRoationModfier(angle: .radians(0), anchor: .topLeading)
        )
    }
    
    
    
}

~~~

