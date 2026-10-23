module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1> : tensor<9x10xi8>}> : () -> tensor<9x10xi8>
    %1 = tosa.clamp %0 {max_val = 122 : i8, min_val = 58 : i8} : (tensor<9x10xi8>) -> tensor<9x10xi8>
    %cast = tensor.cast %1 : tensor<9x10xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

