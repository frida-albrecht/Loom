module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.667400e+02> : tensor<3x6x7xf32>}> : () -> tensor<3x6x7xf32>
    %1 = "tosa.const"() <{values = dense<1.445200e+02> : tensor<3x6x1xf32>}> : () -> tensor<3x6x1xf32>
    %2 = "tosa.const"() <{values = dense<false> : tensor<2x6xi1>}> : () -> tensor<2x6xi1>
    %3 = tosa.minimum %0, %1 : (tensor<3x6x7xf32>, tensor<3x6x1xf32>) -> tensor<3x6x7xf32>
    %4 = tosa.reduce_any %2 {axis = 0 : i32} : (tensor<2x6xi1>) -> tensor<1x6xi1>
    %5 = tosa.argmax %4 {axis = 0 : i32} : (tensor<1x6xi1>) -> tensor<6xi32>
    %6 = tosa.clamp %3 {max_val = 5.600000e+01 : f32, min_val = -4.100000e+01 : f32} : (tensor<3x6x7xf32>) -> tensor<3x6x7xf32>
    %cast = tensor.cast %5 : tensor<6xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<3x6x7xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

