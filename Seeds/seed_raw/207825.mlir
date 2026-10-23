module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<7x8x3xi1>}> : () -> tensor<7x8x3xi1>
    %1 = "tosa.const"() <{values = dense<-1.549500e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = "tosa.const"() <{values = dense<5.000000e-01> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.argmax %0 {axis = 0 : i32} : (tensor<7x8x3xi1>) -> tensor<8x3xi32>
    %4 = tosa.pow %1, %2 : (tensor<f32>, tensor<f32>) -> tensor<f32>
    %5 = tosa.concat %3, %3 {axis = 1 : i32} : (tensor<8x3xi32>, tensor<8x3xi32>) -> tensor<8x6xi32>
    %6 = tosa.identity %5 : (tensor<8x6xi32>) -> tensor<8x6xi32>
    %cast = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<8x6xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

