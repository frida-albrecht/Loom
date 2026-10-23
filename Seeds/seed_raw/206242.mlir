module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9.970000e+00> : tensor<8x1x6x5xf32>}> : () -> tensor<8x1x6x5xf32>
    %1 = "tosa.const"() <{values = dense<10> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = "tosa.const"() <{values = dense<-169> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = tosa.const_shape  {values = dense<[2, 3, 3, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.tile %0, %3 : (tensor<8x1x6x5xf32>, !tosa.shape<4>) -> tensor<16x3x18x5xf32>
    %5 = tosa.bitwise_xor %1, %2 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %6 = tosa.add %5, %5 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %cast = tensor.cast %4 : tensor<16x3x18x5xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

