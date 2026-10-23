module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.923900e+02> : tensor<5x7x1x3xf32>}> : () -> tensor<5x7x1x3xf32>
    %1 = "tosa.const"() <{values = dense<65> : tensor<5x1x7x6xi32>}> : () -> tensor<5x1x7x6xi32>
    %2 = "tosa.const"() <{values = dense<-181> : tensor<5x1x7x1xi32>}> : () -> tensor<5x1x7x1xi32>
    %3 = tosa.const_shape  {values = dense<[3, 1, 1, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %4 = tosa.tile %0, %3 : (tensor<5x7x1x3xf32>, !tosa.shape<4>) -> tensor<15x7x1x9xf32>
    %5 = tosa.bitwise_or %1, %2 : (tensor<5x1x7x6xi32>, tensor<5x1x7x1xi32>) -> tensor<5x1x7x6xi32>
    %cast = tensor.cast %4 : tensor<15x7x1x9xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<5x1x7x6xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

