module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.351000e+01> : tensor<3x10xf32>}> : () -> tensor<3x10xf32>
    %1 = "tosa.const"() <{values = dense<-18> : tensor<4x8xi8>}> : () -> tensor<4x8xi8>
    %2 = "tosa.const"() <{values = dense<-4> : tensor<4x8xi8>}> : () -> tensor<4x8xi8>
    %3 = tosa.exp %0 : (tensor<3x10xf32>) -> tensor<3x10xf32>
    %4 = tosa.concat %3, %3 {axis = 1 : i32} : (tensor<3x10xf32>, tensor<3x10xf32>) -> tensor<3x20xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<4x8xi8>}> : () -> tensor<4x8xi8>
    %c1 = "tosa.const"() <{values = dense<7> : tensor<4x8xi8>}> : () -> tensor<4x8xi8>
    %a0 = tosa.maximum %2, %c0 : (tensor<4x8xi8>, tensor<4x8xi8>) -> tensor<4x8xi8>
    %a1 = tosa.minimum %a0, %c1 : (tensor<4x8xi8>, tensor<4x8xi8>) -> tensor<4x8xi8>
    %5 = tosa.logical_left_shift %1, %a1 : (tensor<4x8xi8>, tensor<4x8xi8>) -> tensor<4x8xi8>
    %6 = tosa.reverse %5 {axis = 0 : i32} : (tensor<4x8xi8>) -> tensor<4x8xi8>
    %7 = tosa.add %4, %4 : (tensor<3x20xf32>, tensor<3x20xf32>) -> tensor<3x20xf32>
    %8 = tosa.exp %7 : (tensor<3x20xf32>) -> tensor<3x20xf32>
    %9 = tosa.reduce_sum %8 {axis = 1 : i32} : (tensor<3x20xf32>) -> tensor<3x1xf32>
    %10 = tosa.maximum %9, %9 : (tensor<3x1xf32>, tensor<3x1xf32>) -> tensor<3x1xf32>
    %11 = tosa.const_shape  {values = dense<32> : tensor<1xindex>} : () -> !tosa.shape<1>
    %12 = tosa.reshape %6, %11 : (tensor<4x8xi8>, !tosa.shape<1>) -> tensor<32xi8>
    %13 = tosa.sigmoid %10 : (tensor<3x1xf32>) -> tensor<3x1xf32>
    %cast = tensor.cast %12 : tensor<32xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %13 : tensor<3x1xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}