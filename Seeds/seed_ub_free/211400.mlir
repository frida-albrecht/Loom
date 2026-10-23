module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-2> : tensor<5x8xi8>}> : () -> tensor<5x8xi8>
    %1 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<5x8xi8>) -> tensor<1x8xi8>
    %cast = tensor.cast %1 : tensor<1x8xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

