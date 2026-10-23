module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<48> : tensor<9x4x8x4xi32>}> : () -> tensor<9x4x8x4xi32>
    %1 = tosa.bitwise_not %0 : (tensor<9x4x8x4xi32>) -> tensor<9x4x8x4xi32>
    %cast = tensor.cast %1 : tensor<9x4x8x4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

