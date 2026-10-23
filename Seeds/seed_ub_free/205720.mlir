module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<176> : tensor<3xi32>}> : () -> tensor<3xi32>
    %1 = "tosa.const"() <{values = dense<-2.842000e+01> : tensor<2x7x2x9xf32>}> : () -> tensor<2x7x2x9xf32>
    %2 = tosa.const_shape  {values = dense<[3, 1, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %3 = tosa.reshape %0, %2 : (tensor<3xi32>, !tosa.shape<4>) -> tensor<3x1x1x1xi32>
    %4 = tosa.log %1 : (tensor<2x7x2x9xf32>) -> tensor<2x7x2x9xf32>
    %5 = tosa.const_shape  {values = dense<[2, 1, 3, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %6 = tosa.tile %3, %5 : (tensor<3x1x1x1xi32>, !tosa.shape<4>) -> tensor<6x1x3x2xi32>
    %7 = tosa.log %4 : (tensor<2x7x2x9xf32>) -> tensor<2x7x2x9xf32>
    %cast = tensor.cast %6 : tensor<6x1x3x2xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %7 : tensor<2x7x2x9xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

