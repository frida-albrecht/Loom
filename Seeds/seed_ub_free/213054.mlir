module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-12> : tensor<2x9x2x1xi8>}> : () -> tensor<2x9x2x1xi8>
    %1 = "tosa.const"() <{values = dense<-1.175800e+02> : tensor<2xf32>}> : () -> tensor<2xf32>
    %2 = tosa.reduce_min %0 {axis = 3 : i32} : (tensor<2x9x2x1xi8>) -> tensor<2x9x2x1xi8>
    %3 = tosa.bitwise_not %2 : (tensor<2x9x2x1xi8>) -> tensor<2x9x2x1xi8>
    %4 = tosa.const_shape  {values = dense<[3, 6, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %5 = tosa.reshape %3, %4 : (tensor<2x9x2x1xi8>, !tosa.shape<3>) -> tensor<3x6x2xi8>
    %6 = tosa.identity %5 : (tensor<3x6x2xi8>) -> tensor<3x6x2xi8>
    %7 = tosa.bitwise_or %6, %6 : (tensor<3x6x2xi8>, tensor<3x6x2xi8>) -> tensor<3x6x2xi8>
    %8 = tosa.rsqrt %1 : (tensor<2xf32>) -> tensor<2xf32>
    %cast = tensor.cast %7 : tensor<3x6x2xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %8 : tensor<2xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

