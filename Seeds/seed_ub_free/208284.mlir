module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1> : tensor<1xi8>}> : () -> tensor<1xi8>
    %1 = "tosa.const"() <{values = dense<5> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = tosa.logical_left_shift %0, %1 : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %3 = tosa.reverse %2 {axis = 0 : i32} : (tensor<1xi8>) -> tensor<1xi8>
    %cast = tensor.cast %3 : tensor<1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

