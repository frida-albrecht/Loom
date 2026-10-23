module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-77> : tensor<i16>}> : () -> tensor<i16>
    %1 = "tosa.const"() <{values = dense<-1.355700e+02> : tensor<9x10xf32>}> : () -> tensor<9x10xf32>
    %2 = tosa.identity %0 : (tensor<i16>) -> tensor<i16>
    %3 = tosa.reduce_min %1 {axis = 1 : i32} : (tensor<9x10xf32>) -> tensor<9x1xf32>
    %cast = tensor.cast %2 : tensor<i16> to tensor<*xi16>
    %cast_0 = tensor.cast %3 : tensor<9x1xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

