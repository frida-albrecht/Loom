module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1> : tensor<4xi8>}> : () -> tensor<4xi8>
    %1 = "tosa.const"() <{values = dense<-14> : tensor<1xi8>}> : () -> tensor<1xi8>
    %2 = tosa.bitwise_and %0, %1 : (tensor<4xi8>, tensor<1xi8>) -> tensor<4xi8>
    %3 = tosa.bitwise_xor %2, %2 : (tensor<4xi8>, tensor<4xi8>) -> tensor<4xi8>
    %4 = tosa.argmax %3 {axis = 0 : i32} : (tensor<4xi8>) -> tensor<i32>
    %5 = tosa.minimum %2, %2 : (tensor<4xi8>, tensor<4xi8>) -> tensor<4xi8>
    %6 = tosa.identity %4 : (tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %5 : tensor<4xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %6 : tensor<i32> to tensor<*xi32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

