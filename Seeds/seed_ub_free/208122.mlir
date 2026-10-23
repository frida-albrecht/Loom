module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-162> : tensor<9x7x9xi64>}> : () -> tensor<9x7x9xi64>
    %1 = "tosa.const"() <{values = dense<-6.558000e+01> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.argmax %0 {axis = 2 : i32} : (tensor<9x7x9xi64>) -> tensor<9x7xi32>
    %3 = tosa.rsqrt %1 : (tensor<f32>) -> tensor<f32>
    %4 = tosa.reciprocal %3 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.argmax %2 {axis = 1 : i32} : (tensor<9x7xi32>) -> tensor<9xi32>
    %cast = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<9xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

