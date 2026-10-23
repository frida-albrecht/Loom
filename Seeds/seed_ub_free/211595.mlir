module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<7.208000e+01> : tensor<6x5x7xf32>}> : () -> tensor<6x5x7xf32>
    %1 = tosa.const_shape  {values = dense<[3, 2, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %2 = tosa.tile %0, %1 : (tensor<6x5x7xf32>, !tosa.shape<3>) -> tensor<18x10x7xf32>
    %3 = tosa.rsqrt %2 : (tensor<18x10x7xf32>) -> tensor<18x10x7xf32>
    %cast = tensor.cast %3 : tensor<18x10x7xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

