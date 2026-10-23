module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-10> : tensor<2xi8>}> : () -> tensor<2xi8>
    %1 = tosa.clamp %0 {max_val = 83 : i8, min_val = -17 : i8} : (tensor<2xi8>) -> tensor<2xi8>
    %2 = tosa.identity %1 : (tensor<2xi8>) -> tensor<2xi8>
    %3 = tosa.reduce_max %2 {axis = 0 : i32} : (tensor<2xi8>) -> tensor<1xi8>
    %4 = tosa.reduce_product %3 {axis = 0 : i32} : (tensor<1xi8>) -> tensor<1xi8>
    %cast = tensor.cast %4 : tensor<1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

