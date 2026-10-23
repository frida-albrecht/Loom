module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<30> : tensor<7x7x1xi32>}> : () -> tensor<7x7x1xi32>
    %1 = "tosa.const"() <{values = dense<-1.348300e+02> : tensor<4x1xf32>}> : () -> tensor<4x1xf32>
    %2 = tosa.const_shape  {values = dense<[1, 2, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %3 = tosa.tile %0, %2 : (tensor<7x7x1xi32>, !tosa.shape<3>) -> tensor<7x14x1xi32>
    %4 = tosa.ceil %1 : (tensor<4x1xf32>) -> tensor<4x1xf32>
    %5 = tosa.bitwise_xor %3, %3 : (tensor<7x14x1xi32>, tensor<7x14x1xi32>) -> tensor<7x14x1xi32>
    %6 = tosa.const_shape  {values = dense<[1, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %7 = tosa.tile %4, %6 : (tensor<4x1xf32>, !tosa.shape<2>) -> tensor<4x2xf32>
    %8 = tosa.add %5, %3 : (tensor<7x14x1xi32>, tensor<7x14x1xi32>) -> tensor<7x14x1xi32>
    %9 = tosa.clz %8 : (tensor<7x14x1xi32>) -> tensor<7x14x1xi32>
    %10 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %11 = tosa.const_shape  {values = dense<[4, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %12 = tosa.slice %7, %10, %11 : (tensor<4x2xf32>, !tosa.shape<2>, !tosa.shape<2>) -> tensor<4x2xf32>
    %cast = tensor.cast %9 : tensor<7x14x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %12 : tensor<4x2xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

