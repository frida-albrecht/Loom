module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4> : tensor<4xi8>}> : () -> tensor<4xi8>
    %1 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<4xi8>) -> tensor<1xi8>
    %2 = tosa.bitwise_and %1, %1 : (tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = tosa.transpose %2 {perms = array<i32: 0>} : (tensor<1xi8>) -> tensor<1xi8>
    %cast = tensor.cast %4 : tensor<1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

