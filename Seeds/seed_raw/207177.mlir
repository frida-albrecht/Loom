module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<16> : tensor<8x5xi8>}> : () -> tensor<8x5xi8>
    %1 = "tosa.const"() <{values = dense<-170> : tensor<2x2xi64>}> : () -> tensor<2x2xi64>
    %2 = tosa.const_shape  {values = dense<0> : tensor<4xindex>} : () -> !tosa.shape<4>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = tosa.pad %0, %2, %3 : (tensor<8x5xi8>, !tosa.shape<4>, tensor<1xi8>) -> tensor<8x5xi8>
    %cast = tensor.cast %4 : tensor<8x5xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

