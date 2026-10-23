module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<111> : tensor<1x4x7xi32>}> : () -> tensor<1x4x7xi32>
    %1 = "tosa.const"() <{values = dense<-172> : tensor<1x7x10xi32>}> : () -> tensor<1x7x10xi32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<1x4x7xi32>, tensor<1x7x10xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1x4x10xi32>
    %5 = tosa.reverse %4 {axis = 2 : i32} : (tensor<1x4x10xi32>) -> tensor<1x4x10xi32>
    %6 = tosa.const_shape  {values = dense<[2, 1, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %7 = tosa.tile %5, %6 : (tensor<1x4x10xi32>, !tosa.shape<3>) -> tensor<2x4x20xi32>
    %8 = tosa.const_shape  {values = dense<[1, 160]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %9 = tosa.reshape %7, %8 : (tensor<2x4x20xi32>, !tosa.shape<2>) -> tensor<1x160xi32>
    %cast = tensor.cast %9 : tensor<1x160xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

