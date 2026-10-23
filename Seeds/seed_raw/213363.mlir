module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<193> : tensor<1x8x2x3xi32>}> : () -> tensor<1x8x2x3xi32>
    %1 = "tosa.const"() <{values = dense<-1.217300e+02> : tensor<5x7x3x6xf32>}> : () -> tensor<5x7x3x6xf32>
    %2 = tosa.identity %0 : (tensor<1x8x2x3xi32>) -> tensor<1x8x2x3xi32>
    %3 = tosa.const_shape  {values = dense<[2, 12, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %4 = tosa.reshape %2, %3 : (tensor<1x8x2x3xi32>, !tosa.shape<3>) -> tensor<2x12x2xi32>
    %5 = tosa.add %4, %4 : (tensor<2x12x2xi32>, tensor<2x12x2xi32>) -> tensor<2x12x2xi32>
    %6 = tosa.tanh %1 : (tensor<5x7x3x6xf32>) -> tensor<5x7x3x6xf32>
    %cast = tensor.cast %5 : tensor<2x12x2xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<5x7x3x6xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

