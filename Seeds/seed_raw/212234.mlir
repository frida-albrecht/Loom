module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.901200e+02> : tensor<3x10x9xf32>}> : () -> tensor<3x10x9xf32>
    %1 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = tosa.negate %0, %1, %2 : (tensor<3x10x9xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<3x10x9xf32>
    %4 = tosa.const_shape  {values = dense<[2, 2, 3]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %5 = tosa.tile %3, %4 : (tensor<3x10x9xf32>, !tosa.shape<3>) -> tensor<6x20x27xf32>
    %cast = tensor.cast %5 : tensor<6x20x27xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

