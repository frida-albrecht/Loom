module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<68> : tensor<2x9x8x7xi32>}> : () -> tensor<2x9x8x7xi32>
    %1 = "tosa.const"() <{values = dense<119> : tensor<2x9x8x7xi32>}> : () -> tensor<2x9x8x7xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<2x9x8x7xi32>}> : () -> tensor<2x9x8x7xi32>
    %s1 = tosa.maximum %1, %c0 : (tensor<2x9x8x7xi32>, tensor<2x9x8x7xi32>) -> tensor<2x9x8x7xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<2x9x8x7xi32>}> : () -> tensor<2x9x8x7xi32>
    %s2 = tosa.minimum %s1, %c31 : (tensor<2x9x8x7xi32>, tensor<2x9x8x7xi32>) -> tensor<2x9x8x7xi32>
    %2 = tosa.logical_right_shift %0, %s2 : (tensor<2x9x8x7xi32>, tensor<2x9x8x7xi32>) -> tensor<2x9x8x7xi32>
    %3 = tosa.clamp %2 {max_val = 90 : i32, min_val = 63 : i32} : (tensor<2x9x8x7xi32>) -> tensor<2x9x8x7xi32>
    %4 = tosa.bitwise_and %3, %2 : (tensor<2x9x8x7xi32>, tensor<2x9x8x7xi32>) -> tensor<2x9x8x7xi32>
    %cast = tensor.cast %4 : tensor<2x9x8x7xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}