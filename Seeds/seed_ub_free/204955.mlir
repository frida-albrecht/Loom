module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<16> : tensor<4x3xi8>}> : () -> tensor<4x3xi8>
    %1 = "tosa.const"() <{values = dense<10> : tensor<1x3xi8>}> : () -> tensor<1x3xi8>
    %2 = "tosa.const"() <{values = dense<1.328500e+02> : tensor<10x4x2x3xf32>}> : () -> tensor<10x4x2x3xf32>
    %3 = tosa.minimum %0, %1 : (tensor<4x3xi8>, tensor<1x3xi8>) -> tensor<4x3xi8>
    %4 = tosa.const_shape  {values = dense<[2, 6, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %5 = tosa.reshape %3, %4 : (tensor<4x3xi8>, !tosa.shape<3>) -> tensor<2x6x1xi8>
    %6 = tosa.add %5, %5 : (tensor<2x6x1xi8>, tensor<2x6x1xi8>) -> tensor<2x6x1xi8>
    %7 = tosa.argmax %6 {axis = 1 : i32} : (tensor<2x6x1xi8>) -> tensor<2x1xi32>
    %8 = tosa.tanh %2 : (tensor<10x4x2x3xf32>) -> tensor<10x4x2x3xf32>
    %cast = tensor.cast %7 : tensor<2x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %8 : tensor<10x4x2x3xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

