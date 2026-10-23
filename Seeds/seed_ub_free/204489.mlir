module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<1x6xi1>}> : () -> tensor<1x6xi1>
    %1 = "tosa.const"() <{values = dense<true> : tensor<1x1xi1>}> : () -> tensor<1x1xi1>
    %2 = "tosa.const"() <{values = dense<1.772700e+02> : tensor<5x9x9x10xf32>}> : () -> tensor<5x9x9x10xf32>
    %3 = tosa.add %0, %1 : (tensor<1x6xi1>, tensor<1x1xi1>) -> tensor<1x6xi1>
    %4 = tosa.reduce_sum %3 {axis = 0 : i32} : (tensor<1x6xi1>) -> tensor<1x6xi1>
    %5 = tosa.rsqrt %2 : (tensor<5x9x9x10xf32>) -> tensor<5x9x9x10xf32>
    %6 = tosa.bitwise_or %4, %4 : (tensor<1x6xi1>, tensor<1x6xi1>) -> tensor<1x6xi1>
    %7 = tosa.argmax %6 {axis = 0 : i32} : (tensor<1x6xi1>) -> tensor<6xi32>
    %cast = tensor.cast %5 : tensor<5x9x9x10xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<6xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

