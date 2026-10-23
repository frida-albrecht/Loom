module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5.385000e+01> : tensor<8x10xf32>}> : () -> tensor<8x10xf32>
    %1 = tosa.const_shape  {values = dense<[1, 10, 8]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.reshape %0, %1 : (tensor<8x10xf32>, !tosa.shape<3>) -> tensor<1x10x8xf32>
    %3 = tosa.log %2 : (tensor<1x10x8xf32>) -> tensor<1x10x8xf32>
    %4 = tosa.identity %3 : (tensor<1x10x8xf32>) -> tensor<1x10x8xf32>
    %cast = tensor.cast %4 : tensor<1x10x8xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

