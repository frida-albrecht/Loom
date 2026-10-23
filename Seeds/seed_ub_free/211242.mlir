module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7> : tensor<5x7x2xi8>}> : () -> tensor<5x7x2xi8>
    %1 = tosa.clz %0 : (tensor<5x7x2xi8>) -> tensor<5x7x2xi8>
    %2 = tosa.reduce_sum %1 {axis = 1 : i32} : (tensor<5x7x2xi8>) -> tensor<5x1x2xi8>
    %3 = tosa.minimum %2, %2 : (tensor<5x1x2xi8>, tensor<5x1x2xi8>) -> tensor<5x1x2xi8>
    %cast = tensor.cast %3 : tensor<5x1x2xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

