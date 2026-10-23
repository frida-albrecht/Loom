module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<37> : tensor<8x10x9xi32>}> : () -> tensor<8x10x9xi32>
    %1 = tosa.const_shape  {values = dense<[3, 1, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.tile %0, %1 : (tensor<8x10x9xi32>, !tosa.shape<3>) -> tensor<24x10x9xi32>
    %3 = tosa.bitwise_not %2 : (tensor<24x10x9xi32>) -> tensor<24x10x9xi32>
    %cast = tensor.cast %3 : tensor<24x10x9xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

