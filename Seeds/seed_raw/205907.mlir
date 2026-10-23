module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<16> : tensor<6xi8>}> : () -> tensor<6xi8>
    %1 = "tosa.const"() <{values = dense<8.340000e+00> : tensor<7x9x7xf32>}> : () -> tensor<7x9x7xf32>
    %2 = "tosa.const"() <{values = dense<1.126600e+02> : tensor<1x1x1xf32>}> : () -> tensor<1x1x1xf32>
    %3 = tosa.clz %0 : (tensor<6xi8>) -> tensor<6xi8>
    %4 = tosa.const_shape  {values = dense<[2, 3, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %5 = tosa.reshape %3, %4 : (tensor<6xi8>, !tosa.shape<3>) -> tensor<2x3x1xi8>
    %6 = tosa.pow %1, %2 : (tensor<7x9x7xf32>, tensor<1x1x1xf32>) -> tensor<7x9x7xf32>
    %cast = tensor.cast %5 : tensor<2x3x1xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %6 : tensor<7x9x7xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

