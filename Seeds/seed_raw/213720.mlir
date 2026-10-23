module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<12> : tensor<10xi8>}> : () -> tensor<10xi8>
    %1 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<10xi8>) -> tensor<1xi8>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = tosa.negate %1, %2, %3 : (tensor<1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<1xi8>
    %cast = tensor.cast %4 : tensor<1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

