module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.822000e+02> : tensor<7x3x1xf32>}> : () -> tensor<7x3x1xf32>
    %1 = "tosa.const"() <{values = dense<91.3399963> : tensor<3x6x3xf32>}> : () -> tensor<3x6x3xf32>
    %2 = tosa.argmax %0 {axis = 1 : i32} : (tensor<7x3x1xf32>) -> tensor<7x1xi32>
    %3 = tosa.reduce_product %2 {axis = 0 : i32} : (tensor<7x1xi32>) -> tensor<1x1xi32>
    %4 = tosa.const_shape  {values = dense<[1, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %5 = tosa.tile %3, %4 : (tensor<1x1xi32>, !tosa.shape<2>) -> tensor<1x2xi32>
    %6 = tosa.minimum %5, %5 : (tensor<1x2xi32>, tensor<1x2xi32>) -> tensor<1x2xi32>
    %7 = tosa.exp %1 : (tensor<3x6x3xf32>) -> tensor<3x6x3xf32>
    %cast = tensor.cast %6 : tensor<1x2xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %7 : tensor<3x6x3xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

