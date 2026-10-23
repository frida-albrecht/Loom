module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.977600e+02> : tensor<2x10xf32>}> : () -> tensor<2x10xf32>
    %1 = "tosa.const"() <{values = dense<15> : tensor<2xi8>}> : () -> tensor<2xi8>
    %2 = tosa.log %0 : (tensor<2x10xf32>) -> tensor<2x10xf32>
    %3 = tosa.bitwise_not %1 : (tensor<2xi8>) -> tensor<2xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<2xi8>}> : () -> tensor<2xi8>
    %tmp0 = tosa.maximum %3, %c0 : (tensor<2xi8>, tensor<2xi8>) -> tensor<2xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<2xi8>}> : () -> tensor<2xi8>
    %tmp1 = tosa.minimum %tmp0, %c7 : (tensor<2xi8>, tensor<2xi8>) -> tensor<2xi8>
    %4 = tosa.logical_right_shift %3, %tmp1 : (tensor<2xi8>, tensor<2xi8>) -> tensor<2xi8>
    %5 = tosa.identity %3 : (tensor<2xi8>) -> tensor<2xi8>
    %6 = tosa.maximum %4, %4 : (tensor<2xi8>, tensor<2xi8>) -> tensor<2xi8>
    %cast = tensor.cast %2 : tensor<2x10xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<2xi8> to tensor<*xi8>
    %cast_1 = tensor.cast %6 : tensor<2xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    call @printMemrefI8(%cast_1) : (tensor<*xi8>) -> ()
    return
  }
}