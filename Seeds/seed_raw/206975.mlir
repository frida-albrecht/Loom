module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-10> : tensor<i8>}> : () -> tensor<i8>
    %1 = tosa.clamp %0 {max_val = 43 : i8, min_val = 23 : i8} : (tensor<i8>) -> tensor<i8>
    %cast = tensor.cast %1 : tensor<i8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

