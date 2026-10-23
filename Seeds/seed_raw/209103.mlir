module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-141> : tensor<7x9x9xi64>}> : () -> tensor<7x9x9xi64>
    %1 = "tosa.const"() <{values = dense<-4.546000e+01> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.argmax %0 {axis = 1 : i32} : (tensor<7x9x9xi64>) -> tensor<7x9xi32>
    %3 = tosa.exp %1 : (tensor<f32>) -> tensor<f32>
    %4 = tosa.exp %3 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %2 : tensor<7x9xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

