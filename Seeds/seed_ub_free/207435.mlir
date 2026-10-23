module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<3xi1>}> : () -> tensor<3xi1>
    %1 = "tosa.const"() <{values = dense<false> : tensor<1xi1>}> : () -> tensor<1xi1>
    %2 = "tosa.const"() <{values = dense<1.682500e+02> : tensor<6x9x8x4xf32>}> : () -> tensor<6x9x8x4xf32>
    %3 = tosa.logical_xor %0, %1 : (tensor<3xi1>, tensor<1xi1>) -> tensor<3xi1>
    %4 = tosa.clz %3 : (tensor<3xi1>) -> tensor<3xi1>
    %5 = tosa.reciprocal %2 : (tensor<6x9x8x4xf32>) -> tensor<6x9x8x4xf32>
    %6 = tosa.argmax %4 {axis = 0 : i32} : (tensor<3xi1>) -> tensor<i32>
    %cast = tensor.cast %5 : tensor<6x9x8x4xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<i32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

