module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.210000e+00> : tensor<8xf32>}> : () -> tensor<8xf32>
    %1 = "tosa.const"() <{values = dense<-8> : tensor<8x2xi8>}> : () -> tensor<8x2xi8>
    %2 = "tosa.const"() <{values = dense<4> : tensor<8x1xi8>}> : () -> tensor<8x1xi8>
    %3 = tosa.exp %0 : (tensor<8xf32>) -> tensor<8xf32>
    %4 = tosa.logical_right_shift %1, %2 : (tensor<8x2xi8>, tensor<8x1xi8>) -> tensor<8x2xi8>
    %5 = tosa.ceil %3 : (tensor<8xf32>) -> tensor<8xf32>
    %cast = tensor.cast %4 : tensor<8x2xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %5 : tensor<8xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

