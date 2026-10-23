module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<114> : tensor<6x10xi64>}> : () -> tensor<6x10xi64>
    %1 = "tosa.const"() <{values = dense<-8.025000e+01> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.reverse %0 {axis = 1 : i32} : (tensor<6x10xi64>) -> tensor<6x10xi64>
    %3 = tosa.bitwise_or %2, %2 : (tensor<6x10xi64>, tensor<6x10xi64>) -> tensor<6x10xi64>
    %4 = tosa.sigmoid %1 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.argmax %3 {axis = 1 : i32} : (tensor<6x10xi64>) -> tensor<6xi32>
    %6 = tosa.reciprocal %4 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %5 : tensor<6xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<f32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

