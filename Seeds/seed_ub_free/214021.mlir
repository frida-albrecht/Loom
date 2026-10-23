module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.847800e+02> : tensor<6x8x9x3xf32>}> : () -> tensor<6x8x9x3xf32>
    %1 = "tosa.const"() <{values = dense<18> : tensor<2xi8>}> : () -> tensor<2xi8>
    %2 = "tosa.const"() <{values = dense<-4> : tensor<2xi8>}> : () -> tensor<2xi8>
    %3 = tosa.ceil %0 : (tensor<6x8x9x3xf32>) -> tensor<6x8x9x3xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<2xi8>}> : () -> tensor<2xi8>
    %a0 = tosa.maximum %2, %c0 : (tensor<2xi8>, tensor<2xi8>) -> tensor<2xi8>
    %c1 = "tosa.const"() <{values = dense<7> : tensor<2xi8>}> : () -> tensor<2xi8>
    %a1 = tosa.minimum %a0, %c1 : (tensor<2xi8>, tensor<2xi8>) -> tensor<2xi8>
    %4 = tosa.logical_left_shift %1, %a1 : (tensor<2xi8>, tensor<2xi8>) -> tensor<2xi8>
    %5 = tosa.bitwise_not %4 : (tensor<2xi8>) -> tensor<2xi8>
    %6 = tosa.minimum %4, %4 : (tensor<2xi8>, tensor<2xi8>) -> tensor<2xi8>
    %cast = tensor.cast %3 : tensor<6x8x9x3xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<2xi8> to tensor<*xi8>
    %cast_1 = tensor.cast %6 : tensor<2xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    call @printMemrefI8(%cast_1) : (tensor<*xi8>) -> ()
    return
  }
}