module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2.090000e+00> : tensor<7x8x1xf32>}> : () -> tensor<7x8x1xf32>
    %1 = "tosa.const"() <{values = dense<-1.496200e+02> : tensor<7x1x1xf32>}> : () -> tensor<7x1x1xf32>
    %2 = "tosa.const"() <{values = dense<-15> : tensor<2x10x6xi8>}> : () -> tensor<2x10x6xi8>
    %3 = "tosa.const"() <{values = dense<15> : tensor<2x1x1xi8>}> : () -> tensor<2x1x1xi8>
    %4 = tosa.sub %0, %1 : (tensor<7x8x1xf32>, tensor<7x1x1xf32>) -> tensor<7x8x1xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<2x1x1xi8>}> : () -> tensor<2x1x1xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<2x1x1xi8>}> : () -> tensor<2x1x1xi8>
    %l0 = tosa.maximum %3, %c0 : (tensor<2x1x1xi8>, tensor<2x1x1xi8>) -> tensor<2x1x1xi8>
    %l1 = tosa.minimum %l0, %c7 : (tensor<2x1x1xi8>, tensor<2x1x1xi8>) -> tensor<2x1x1xi8>
    %5 = tosa.logical_right_shift %2, %l1 : (tensor<2x10x6xi8>, tensor<2x1x1xi8>) -> tensor<2x10x6xi8>
    %6 = tosa.floor %4 : (tensor<7x8x1xf32>) -> tensor<7x8x1xf32>
    %7 = tosa.abs %6 : (tensor<7x8x1xf32>) -> tensor<7x8x1xf32>
    %8 = tosa.arithmetic_right_shift %5, %5 {round = true} : (tensor<2x10x6xi8>, tensor<2x10x6xi8>) -> tensor<2x10x6xi8>
    %9 = tosa.reduce_min %5 {axis = 2 : i32} : (tensor<2x10x6xi8>) -> tensor<2x10x1xi8>
    %cast = tensor.cast %7 : tensor<7x8x1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<2x10x6xi8> to tensor<*xi8>
    %cast_1 = tensor.cast %9 : tensor<2x10x1xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    call @printMemrefI8(%cast_1) : (tensor<*xi8>) -> ()
    return
  }
}