module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-11> : tensor<4x4xi8>}> : () -> tensor<4x4xi8>
    %1 = tosa.reduce_sum %0 {axis = 1 : i32} : (tensor<4x4xi8>) -> tensor<4x1xi8>
    %2 = tosa.reverse %1 {axis = 1 : i32} : (tensor<4x1xi8>) -> tensor<4x1xi8>
    %3 = tosa.sub %2, %2 : (tensor<4x1xi8>, tensor<4x1xi8>) -> tensor<4x1xi8>
    %cast = tensor.cast %3 : tensor<4x1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

