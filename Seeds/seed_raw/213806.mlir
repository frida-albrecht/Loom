module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.279100e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-13> : tensor<9x3xi8>}> : () -> tensor<9x3xi8>
    %2 = tosa.tanh %0 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.argmax %1 {axis = 1 : i32} : (tensor<9x3xi8>) -> tensor<9xi32>
    %4 = tosa.identity %2 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %3 : tensor<9xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

