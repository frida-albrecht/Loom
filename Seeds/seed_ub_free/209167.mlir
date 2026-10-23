module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<20> : tensor<6x1xi8>}> : () -> tensor<6x1xi8>
    %1 = tosa.clamp %0 {max_val = 58 : i8, min_val = -21 : i8} : (tensor<6x1xi8>) -> tensor<6x1xi8>
    %cast = tensor.cast %1 : tensor<6x1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}

