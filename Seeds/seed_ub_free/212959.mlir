module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8> : tensor<9x3x10x7xi8>}> : () -> tensor<9x3x10x7xi8>
    %1 = "tosa.const"() <{values = dense<-137> : tensor<4x2xi64>}> : () -> tensor<4x2xi64>
    %2 = tosa.const_shape  {values = dense<0> : tensor<8xindex>} : () -> !tosa.shape<8>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = tosa.pad %0, %2, %3 : (tensor<9x3x10x7xi8>, !tosa.shape<8>, tensor<1xi8>) -> tensor<9x3x10x7xi8>
    %cast = tensor.cast %4 : tensor<9x3x10x7xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

