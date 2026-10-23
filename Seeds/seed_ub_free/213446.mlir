module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1> : tensor<9x7x5xi8>}> : () -> tensor<9x7x5xi8>
    %1 = "tosa.const"() <{values = dense<-3> : tensor<9x5x2xi8>}> : () -> tensor<9x5x2xi8>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<9x7x5xi8>, tensor<9x5x2xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<9x7x2xi8>
    %cast = tensor.cast %4 : tensor<9x7x2xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

