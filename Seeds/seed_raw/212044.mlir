module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4> : tensor<4xi8>}> : () -> tensor<4xi8>
    %1 = "tosa.const"() <{values = dense<-18> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = tosa.arithmetic_right_shift %0, %1 {round = true} : (tensor<4xi8>, tensor<1xi8>) -> tensor<4xi8>
    %3 = tosa.reduce_min %2 {axis = 0 : i32} : (tensor<4xi8>) -> tensor<1xi8>
    %cast = tensor.cast %3 : tensor<1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

