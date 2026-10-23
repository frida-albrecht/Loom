module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<195> : tensor<5xi16>}> : () -> tensor<5xi16>
    %1 = "tosa.const"() <{values = dense<6> : tensor<6xi8>}> : () -> tensor<6xi8>
    %2 = "tosa.const"() <{values = dense<-17> : tensor<6xi8>}> : () -> tensor<6xi8>
    %3 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<5xi16>) -> tensor<1xi16>
    %4 = tosa.reverse %3 {axis = 0 : i32} : (tensor<1xi16>) -> tensor<1xi16>
    %5 = tosa.maximum %1, %2 : (tensor<6xi8>, tensor<6xi8>) -> tensor<6xi8>
    %cast = tensor.cast %4 : tensor<1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %5 : tensor<6xi8> to tensor<*xi8>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

