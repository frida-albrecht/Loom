module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5> : tensor<2x1x10xi8>}> : () -> tensor<2x1x10xi8>
    %1 = "tosa.const"() <{values = dense<-179> : tensor<3x2xi64>}> : () -> tensor<3x2xi64>
    %2 = "tosa.const"() <{values = dense<5.476000e+01> : tensor<5xf32>}> : () -> tensor<5xf32>
    %3 = tosa.const_shape  {values = dense<0> : tensor<6xindex>} : () -> !tosa.shape<6>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = tosa.pad %0, %3, %4 : (tensor<2x1x10xi8>, !tosa.shape<6>, tensor<1xi8>) -> tensor<2x1x10xi8>
    %6 = tosa.ceil %2 : (tensor<5xf32>) -> tensor<5xf32>
    %7 = tosa.ceil %6 : (tensor<5xf32>) -> tensor<5xf32>
    %8 = tosa.exp %6 : (tensor<5xf32>) -> tensor<5xf32>
    %9 = tosa.rsqrt %7 : (tensor<5xf32>) -> tensor<5xf32>
    %10 = tosa.bitwise_and %5, %5 : (tensor<2x1x10xi8>, tensor<2x1x10xi8>) -> tensor<2x1x10xi8>
    %11 = tosa.reduce_sum %9 {axis = 0 : i32} : (tensor<5xf32>) -> tensor<1xf32>
    %t13 = "tosa.const"() <{values = dense<0> : tensor<2x1x10xi8>}> : () -> tensor<2x1x10xi8>
    %t14 = tosa.maximum %10, %t13 : (tensor<2x1x10xi8>, tensor<2x1x10xi8>) -> tensor<2x1x10xi8>
    %t15 = "tosa.const"() <{values = dense<7> : tensor<2x1x10xi8>}> : () -> tensor<2x1x10xi8>
    %t16 = tosa.minimum %t14, %t15 : (tensor<2x1x10xi8>, tensor<2x1x10xi8>) -> tensor<2x1x10xi8>
    %12 = tosa.logical_right_shift %10, %t16 : (tensor<2x1x10xi8>, tensor<2x1x10xi8>) -> tensor<2x1x10xi8>
    %cast = tensor.cast %8 : tensor<5xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %11 : tensor<1xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %12 : tensor<2x1x10xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_1) : (tensor<*xi8>) -> ()
    return
  }
}